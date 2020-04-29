# Comments
docker volume create cassandra_data
docker run --rm -d --name cassandra -p 9042:9042 -v cassandra_data:/var/lib/cassandra -v $PWD/cassandra.yaml:/etc/cassandra/cassandra.yaml cassandra:2.2

#Change cassandra superuser
cqlsh -u cassandra -p cassandra
CREATE ROLE root WITH PASSWORD = 'CassandraRootPassword' AND SUPERUSER = true AND LOGIN = true;
CREATE KEYSPACE wasabi WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };
CREATE USER 'cassandrauser' WITH PASSWORD 'CassandraPassword';
GRANT ALL ON KEYSPACE wasabi TO 'cassandrauser';

cqlsh -u root -p CassandraRootPassword
ALTER ROLE cassandra WITH PASSWORD='SomeoneThatNoOneWillThinkOf' AND SUPERUSER=false;
UPDATE system.local SET cluster_name = 'CTL Cluster' where key='local';

# Connection String
cqlsh -u cassandrauser -p CassandraPassword -k wasabi 148.156.88.72 9042 --cqlversion='3.3.1' --encoding utf-8
