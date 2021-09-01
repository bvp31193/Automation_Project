
myname="Vivek"
timestamp=$(date '+%d%m%Y-%H%M%S')
s3_bucket="upgrad-vivekpandi"
sudo apt update -y
sudo apt-get install apache2 -y
ps -ef | grep apache2 |grep -v grep > /dev/null
if [ $? != 0 ]
then
       /etc/init.d/apache2 start > /dev/null
fi
systemctl enable apache2
sudo tar -cvf /tmp/${myname}-httpd-logs-${timestamp}.tar /var/log/apache2/*.log
aws s3 \
cp /tmp/${myname}-httpd-logs-${timestamp}.tar \
s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
touch /etc/cron.d/automation
echo "* * * * * root /root/Automation_Project/automation.sh" >> /etc/cron.d/automation
crontab /etc/cron.d/automation
rm -rf /etc/cron.d/automation
