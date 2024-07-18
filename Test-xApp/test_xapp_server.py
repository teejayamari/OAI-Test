import grpc
from concurrent import futures
import time
import test_xapp_pb2
import test_xapp_pb2_grpc

class TestXAppServiceServicer(test_xapp_pb2_grpc.TestXAppServiceServicer):
    def CheckServerStatus(self, request, context):
        return test_xapp_pb2.StatusResponse(isRunning=True, message="Test xApp server is up and running")

    def StreamServerStatus(self, request, context):
        while True:
            yield test_xapp_pb2.StatusResponse(isRunning=True, message="Test xApp server is up and running")
            time.sleep(60)  # Adjust the interval to 60 seconds

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    test_xapp_pb2_grpc.add_TestXAppServiceServicer_to_server(TestXAppServiceServicer(), server)
    server.add_insecure_port('[::]:50051')
    server.start()
    print("Server started and listening on port 50051")
    try:
        while True:
            time.sleep(86400)
    except KeyboardInterrupt:
        server.stop(0)
        print("Server stopped")

if __name__ == '__main__':
    serve()

