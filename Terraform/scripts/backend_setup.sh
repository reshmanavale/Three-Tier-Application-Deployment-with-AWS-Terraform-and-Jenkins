#!/bin/bash

# Navigate to frontend project folder (adjust path as needed)
cd /home/ubuntu/frontend

# Update the backend URL in url.js
echo "export const URL = 'http://10.0.2.224:3001';" > src/url.js

# Install dependencies and run
npm install
npm run build
npm install -g serve
serve -s build -l 3000
