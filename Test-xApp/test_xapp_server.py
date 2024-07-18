import grpc
from concurrent import futures
import time
import test_xapp_pb2
import test_xapp_pb2_grpc

class TestXAppServiceServicer(test_xapp_pb2_grpc.TestXAppServiceServicer):
    def CheckServerStatus(self, request, context):
        return test_xapp_pb2.StatusResponse(isRunning=True, message="Test xApp server is up and running")

def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=10))
    test_xapp_pb2_grpc.add_TestXAppServiceServicer_to_server(TestXAppServiceServicer(), server)
    server.add_insecure_port('[::]:50051')
    server.start()
    try:
        while True:
            time.sleep(86400)
    except KeyboardInterrupt:
        server.stop(0)

if __name__ == '__main__':
    serve()

