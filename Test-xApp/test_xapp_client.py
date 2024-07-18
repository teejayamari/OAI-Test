import grpc
import test_xapp_pb2
import test_xapp_pb2_grpc
import threading
import time

def listen_for_updates(stub):
    request = test_xapp_pb2.StatusRequest()
    while True:
        try:
            for response in stub.StreamServerStatus(request):
                print("Server status: ", response.message)
        except grpc.RpcError as e:
            print("Server connection lost, retrying...")
            time.sleep(5)  # Wait before retrying
            continue

def run():
    while True:
        try:
            with grpc.insecure_channel('localhost:50051') as channel:
                stub = test_xapp_pb2_grpc.TestXAppServiceStub(channel)
                
                listener_thread = threading.Thread(target=listen_for_updates, args=(stub,))
                listener_thread.start()
                
                while True:
                    command = input("Enter 'exit' to quit: ")
                    if command.strip().lower() == 'exit':
                        print("Exiting client...")
                        return

        except grpc.RpcError as e:
            print(f"Failed to connect to server: {e}")
            time.sleep(5)  # Wait before retrying

if __name__ == '__main__':
    run()

