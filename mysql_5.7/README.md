# Comments
docker volume create mysql_data
docker run --rm -d --name mysql -p 3306:3306 -v mysql_data:/var/lib/mysql mysql:5.7
