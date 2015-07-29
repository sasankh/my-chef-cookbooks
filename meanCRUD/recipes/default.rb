#
# Cookbook Name:: meanCRUD
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

# The receipe clones git Project with the provided git project link


powershell_script 'Install mongodb and create the database and log folder' do
  code 'Invoke-WebRequest https://fastdl.mongodb.org/win32/mongodb-win32-x86_64-2008plus-ssl-3.0.5-signed.msi?_ga=1.209062356.738451682.1438126329 -OutFile C:\Users\Administrator\Desktop\mongodb-win32-x86_64-2008plus-ssl-3.0.5-signed.msi
  cd C:\Users\Administrator\Desktop\
  msiexec.exe /q /i mongodb-win32-x86_64-2008plus-ssl-3.0.5-signed.msi INSTALLLOCATION="C:\mongodb" ADDLOCAL="all"
  md C:\database\data\db
  md C:\database\data\log'
end

file 'C:\database\data\log\log.txt' do
  content ''
end

powershell_script 'set mongodb as service and start' do
  code 'C:\mongodb\bin\mongod.exe --dbpath=C:\database\data --logpath=C:\database\data\log\log.txt --install'
end

powershell_script 'start mongodb' do
  code 'net start MongoDB'
end

powershell_script 'Retrive MEAN-CRUD from gitHub' do
  code 'git clone https://github.com/sasankh/MEAN-CRUD.git C:\Users\Administrator\Desktop\MEANcrud
  cd C:\Users\Administrator\Desktop\MEANcrud'
end

powershell_script 'set mongodb as service, npm install of CRUD dependencies and start server' do
  code 'C:\mongodb\bin\mongorestore.exe --db CRUD C:\Users\Administrator\Desktop\MEANcrud\dbDUMP\CRUD
  cd C:\Users\Administrator\Desktop\MEANcrud
  npm install
  node server.js'
end
