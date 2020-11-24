from rest_framework import generics
from .serializers import LoginSerializer, UserSerializer, RegisterSerializer
from knox.models import AuthToken
from rest_framework.response import Response

class LoginAPI(generics.GenericAPIView):
    serializer_class = LoginSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data = request.data) # Load request body to serializer
        serializer.is_valid(raise_exception = True) # Validate data in serializer and raise an error if one is found
      
        user = serializer.validated_data # Get the validated data from the serializer
        token = AuthToken.objects.create(user)[1] # Create an Authentication Token for the user
       
        return Response({
            "user": UserSerializer(user, context = self.get_serializer_context()).data,
            "token": token
        })


class RegisterAPI(generics.GenericAPIView):
    serializer_class = RegisterSerializer

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data) # Load request body to serializer
        serializer.is_valid(raise_exception=True) # Validate data in serializer and raise an error if one is found
        
        user = serializer.save() # Notice we call save here
        token = AuthToken.objects.create(user)[1] # Create an Authentication Token for the user
        
        return Response({
            "user": UserSerializer(user, context=self.get_serializer_context()).data,
            "token": token
        })