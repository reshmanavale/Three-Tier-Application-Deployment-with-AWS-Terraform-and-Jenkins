#!/bin/bash

BACKEND_PUBLIC_IP=$1

# Update and install dependencies
sudo apt update -y
sudo apt install -y nodejs npm git

# Clone frontend app
git clone https://github.com/UnpredictablePrashant/TravelMemory.git
cd TravelMemory/frontend

# Set backend URL
echo "REACT_APP_BACKEND_URL=http://13.52.163.0:3001" > .env

# Install dependencies and build frontend
npm install
npm run build

# Install and run serve to host the React build
sudo npm install -g serve
nohup serve -s build -l 3000 > frontend.log 2>&1 &
