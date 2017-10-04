#!/bin/bash

#Yogita Jain, jain.yo@husky.neu.edu, 001643815
#Rohan Magare, magare.r@husky.neu.edu, 001231457
#Pratiksha Shetty, shetty.pr@husky.neu.edu, 001643697
#Ritesh Gupta, gupta.rite@husky.neu.edu, 001280361

##Disabling instance termination protection
aws ec2 modify-instance-attribute --instance-id $1 --no-disable-api-termination

##Fetching Security Group Id
sg_id=`aws ec2 describe-instances --instance-ids $1 | grep SECURITYGROUPS | awk '{print $2}'`
echo $sg_id

##Terminating the instance
aws ec2 terminate-instances --instance-ids $1

##Waiting for the instance to get terminated
aws ec2 wait instance-terminated --instance-ids $1

##Deleting the security group
aws ec2 delete-security-group --group-id "$sg_id"


