# 1. Clean Installation Setup

This project was developed on Arch Linux using Java 8, Apache Hadoop 3.3.6, and Apache Hive 3.1.3.

## Clean Previous Installation

Stop any existing Hadoop/YARN processes:

```bash
stop-yarn.sh
stop-dfs.sh

pkill -9 -f hadoop
pkill -9 -f java
```

Remove previous Hadoop/Hive installations:

```bash
sudo pacman -Rns hadoop --noconfirm

sudo rm -rf /opt/hadoop
sudo rm -rf /opt/hive
sudo rm -rf /etc/hadoop
sudo rm -rf ~/metastore_db
sudo rm -rf /tmp/hadoop*
sudo rm -rf /tmp/movielens*
```

Clear existing environment variables in Fish:

```fish
set -e HADOOP_HOME
set -e HIVE_HOME

set -Ux HADOOP_HOME ""
set -Ux HIVE_HOME ""
```

---

## Install Java 8

Install OpenJDK 8:

```bash
sudo pacman -Sy jdk8-openjdk --noconfirm
```

Set Java 8 as the default:

```bash
sudo archlinux-java set java-8-openjdk
```

Verify:

```bash
java -version
```

The version should start with:

```text
1.8.0
```

---

## Install Hadoop 3.3.6

Download Hadoop:

```bash
cd ~

wget https://archive.apache.org/dist/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
```

Extract it:

```bash
sudo tar -xzf hadoop-3.3.6.tar.gz -C /opt/
```

Rename the installation directory:

```bash
sudo mv /opt/hadoop-3.3.6 /opt/hadoop
```

Give the current user ownership:

```bash
sudo chown -R $USER:$USER /opt/hadoop
```

Remove the downloaded archive:

```bash
rm hadoop-3.3.6.tar.gz
```

---

## Configure Hadoop Logs

```bash
sudo mkdir -p /var/log/hadoop
sudo mkdir -p /opt/hadoop/logs

sudo chown -R $USER:$USER /var/log/hadoop
sudo chown -R $USER:$USER /opt/hadoop/logs
```

Set Java and Hadoop log directories:

```bash
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk" >> /opt/hadoop/etc/hadoop/hadoop-env.sh

echo "export HADOOP_LOG_DIR=/opt/hadoop/logs" >> /opt/hadoop/etc/hadoop/hadoop-env.sh

echo "export YARN_LOG_DIR=/opt/hadoop/logs" >> /opt/hadoop/etc/hadoop/yarn-env.sh
```

Create the Hadoop configuration link:

```bash
sudo mkdir -p /etc

sudo ln -sfn /opt/hadoop/etc/hadoop /etc/hadoop
```

Configure the worker:

```bash
echo "localhost" > /opt/hadoop/etc/hadoop/workers
```
