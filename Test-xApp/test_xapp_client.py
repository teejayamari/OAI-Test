import grpc
import test_xapp_pb2
import test_xapp_pb2_grpc

def run():
    with grpc.insecure_channel('localhost:50051') as channel:
        stub = test_xapp_pb2_grpc.TestXAppServiceStub(channel)
        response = stub.CheckServerStatus(test_xapp_pb2.StatusRequest())
        print("Server status: ", response.message)

if __name__ == '__main__':
    run()

