# 2. Hadoop Configuration

## core-site.xml

Edit:

```text
/opt/hadoop/etc/hadoop/core-site.xml
```

Configuration:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>
```

---

## hdfs-site.xml

Configuration:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
```

---

## mapred-site.xml

Configuration:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>

    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>

    <property>
        <name>yarn.app.mapreduce.am.env</name>
        <value>HADOOP_MAPRED_HOME=/opt/hadoop</value>
    </property>

    <property>
        <name>mapreduce.map.env</name>
        <value>HADOOP_MAPRED_HOME=/opt/hadoop</value>
    </property>

    <property>
        <name>mapreduce.reduce.env</name>
        <value>HADOOP_MAPRED_HOME=/opt/hadoop</value>
    </property>

</configuration>
```

---

## yarn-site.xml

The YARN configuration enables the MapReduce ShuffleHandler and disables virtual/physical memory checks for this setup.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>

    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>

    <property>
        <name>yarn.nodemanager.aux-services.mapreduce_shuffle.class</name>
        <value>org.apache.hadoop.mapred.ShuffleHandler</value>
    </property>

    <property>
        <name>yarn.nodemanager.vmem-check-enabled</name>
        <value>false</value>
    </property>

    <property>
        <name>yarn.nodemanager.pmem-check-enabled</name>
        <value>false</value>
    </property>

</configuration>
```

---

## Format NameNode

First-time setup only:

```bash
hdfs namenode -format -force
```

---

## Start Hadoop Services

Start HDFS:

```bash
start-dfs.sh
```

Start YARN:

```bash
start-yarn.sh
```

Verify the running daemons:

```bash
jps
```

Expected processes include:

```text
NameNode
DataNode
SecondaryNameNode
ResourceManager
NodeManager
```

---

## Create HDFS Directories

```bash
hdfs dfs -mkdir -p /tmp
hdfs dfs -mkdir -p /user/hive/warehouse

hdfs dfs -chmod -R 777 /tmp
hdfs dfs -chmod -R 777 /user/hive/warehouse
```

Create project directories:

```bash
hdfs dfs -mkdir -p /user/hadoop/movielens/ratings
hdfs dfs -mkdir -p /user/hadoop/movielens/movies
```

---

## Upload MovieLens Dataset

Navigate to the dataset:

```bash
cd ~/Downloads/ml-latest
```

Upload the files:

```bash
hdfs dfs -put -f ratings.csv /user/hadoop/movielens/ratings/
hdfs dfs -put -f movies.csv /user/hadoop/movielens/movies/
```

Verify:

```bash
hdfs dfs -ls -h /user/hadoop/movielens/ratings/
hdfs dfs -ls -h /user/hadoop/movielens/movies/
```
