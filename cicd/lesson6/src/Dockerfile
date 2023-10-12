#Build
FROM centos:7
WORKDIR /python_api

#Installing General Purpose Packages
RUN yum install python3 python3-pip -y 

#Copy requirements
COPY requirements.txt requirements.txt

#Install requirements
RUN pip3 install -r requirements.txt

#Project start 
COPY python-api.py python-api.py
CMD ["python3", "python-api.py"]

