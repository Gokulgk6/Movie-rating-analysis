# 3. Hive Configuration

Install and configure Apache Hive 3.1.3 against the Hadoop 3.3.6 installation from
[02-hadoop-config.md](02-hadoop-config.md).

> This guide assumes Hadoop is already running (`start-dfs.sh` / `start-yarn.sh`)
> and that `JAVA_HOME` points to OpenJDK 8.

---

## 1. Download and Install Hive 3.1.3

```bash
cd ~
wget https://archive.apache.org/dist/hive/hive-3.1.3/apache-hive-3.1.3-bin.tar.gz
sudo tar -xzf apache-hive-3.1.3-bin.tar.gz -C /opt/
sudo mv /opt/apache-hive-3.1.3-bin /opt/hive
sudo chown -R $USER:$USER /opt/hive
rm apache-hive-3.1.3-bin.tar.gz
```

---

## 2. Configure Environment Variables

### Bash / Zsh — add to `~/.bashrc`

```bash
export HIVE_HOME=/opt/hive
export HADOOP_HOME=/opt/hadoop
export PATH=$PATH:$HIVE_HOME/bin
```

Reload:

```bash
source ~/.bashrc
```

### Fish — persistent variables

```fish
set -Ux HIVE_HOME /opt/hive
set -Ux HADOOP_HOME /opt/hadoop
fish_add_path $HIVE_HOME/bin
```

Verify:

```bash
echo $HIVE_HOME
hive --version
```

---

## 3. Make Hadoop Configuration Visible to Hive

Hive needs Hadoop's configuration files. Either copy them or symlink the Hadoop conf
directory into Hive's `conf/`:

```bash
ln -sfn /opt/hadoop/etc/hadoop/core-site.xml /opt/hive/conf/core-site.xml
ln -sfn /opt/hadoop/etc/hadoop/hdfs-site.xml /opt/hive/conf/hdfs-site.xml
ln -sfn /opt/hadoop/etc/hadoop/mapred-site.xml /opt/hive/conf/mapred-site.xml
ln -sfn /opt/hadoop/etc/hadoop/yarn-site.xml /opt/hive/conf/yarn-site.xml
```

---

## 4. Configure the Derby Metastore

Create `$HIVE_HOME/conf/hive-site.xml`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>

    <property>
        <name>javax.jdo.option.ConnectionURL</name>
        <value>jdbc:derby:;databaseName=/home/YOUR_USER/metastore_db;create=true</value>
    </property>

    <property>
        <name>javax.jdo.option.ConnectionDriverName</name>
        <value>org.apache.derby.jdbc.EmbeddedDriver</value>
    </property>

    <property>
        <name>hive.metastore.warehouse.dir</name>
        <value>/user/hive/warehouse</value>
    </property>

    <property>
        <name>hive.metastore.schema.verification</name>
        <value>false</value>
    </property>

    <property>
        <name>hive.auto.convert.join</name>
        <value>false</value>
    </property>

</configuration>
```

Replace `/home/YOUR_USER/metastore_db` with an absolute path you can write to (using
`~` is not expanded inside the JDBC URL).

> `hive.auto.convert.join=false` keeps join execution predictable for the analysis
> queries in this project.

---

## 5. Synchronize the Guava Dependency

Hive 3.1.3 ships an older Guava than Hadoop 3.3.6. Replace Hive's Guava with Hadoop's
copy to avoid runtime `NoSuchMethodError` failures.

```bash
rm /opt/hive/lib/guava-*.jar
cp /opt/hadoop/share/hadoop/common/lib/guava-*.jar /opt/hive/lib/
```

Confirm only one Guava jar remains:

```bash
ls /opt/hive/lib | grep guava
```

---

## 6. Prepare HDFS Directories

Hive needs writable warehouse and scratch directories:

```bash
hdfs dfs -mkdir -p /tmp
hdfs dfs -mkdir -p /user/hive/warehouse

hdfs dfs -chmod -R 777 /tmp
hdfs dfs -chmod -R 777 /user/hive/warehouse
```

---

## 7. Initialize the Metastore Schema

Run once for a fresh Derby metastore:

```bash
schematool -dbType derby -initSchema
```

Expected tail of the output:

```text
Initialization script completed
schemaTool completed
```

If you need to reset the metastore, remove `~/metastore_db` and run the command again.

---

## 8. Start Hive

```bash
hive
```

At the `hive>` prompt:

```sql
SHOW DATABASES;
CREATE DATABASE IF NOT EXISTS movie_db;
USE movie_db;
SHOW TABLES;
```

Then continue with [create_tables.sql](../hive/create_tables.sql) and
[analysis_queries.sql](../hive/analysis_queries.sql).

---

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| `NoSuchMethodError: com.google.common...` | Guava mismatch | Repeat step 5 with Hadoop's Guava jar |
| `Failed to connect to metastore` | Derby URL or permissions | Use an absolute path; check write access |
| `Schema not initialized` | Metastore not initialized | `schematool -dbType derby -initSchema` |
| `Permission denied` on warehouse | HDFS directory ownership | `hdfs dfs -chmod -R 777 /user/hive/warehouse` |
| Hive cannot find HDFS | Hadoop conf not linked | Repeat step 3 and verify `fs.defaultFS` |
| Derby lock errors | Multiple Hive sessions | Close other Hive/Derby clients and retry |
