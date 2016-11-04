
Hadoop container for development purposes.  Runs HDFS and/or Yarn.

To run:

```

  docker run -p 9000:9000 cybermaggedon/hadoop:2.7.3

```

To persist data, mount a volume on /data:

```

  docker run -p 9000:9000 -v /data/hadoop:/data cybermaggedon/hadoop:2.7.3

```

To run in cluster mode, you need to change some environment variables:

- ```DAEMONS```: Comma-separated list of daemons to start.  Valid daemons are:
  namenode, secondarynamenode, datanode for clustered HDFS.  For Yarn,
  resourcemanager, nodemanager and proxyserver.  Default is everything
  except proxyserver.
- ```NAMENODE_URI```: URI of the HDFS namenode e.g. ```hdfs://host1:9000```,
  default is ```hdfs://localhost:9000```.
- ```DFS_REPLICATION```: Replication factor, default is 1.  3 is good if you
  want a data-resilient cluster, but you need at least 3 nodes.
- ```RESOURCEMANAGER_HOSTNAME```: Hostname for nodemanagers to locate the
  resourcemanager.

Running an HDFS cluster:

```

  # Master
  docker run --rm -e DAEMONS=namenode,datanode,secondarynamenode \
      --name=hadoop01 -p 50070:50070 -p 50075:50075 -p 50090:50090 \
      -p 9000:9000 cybermaggedon/hadoop:2.7.3

  # Slaves
  docker run --rm -e DAEMONS=datanode -e NAMENODE_URI=hdfs://hadoop01:9000 \
      --name=hadoop02 --link hadoop01:hadoop01 -P cybermaggedon/hadoop:2.7.3
  docker run --rm -e DAEMONS=datanode -e NAMENODE_URI=hdfs://hadoop01:9000 \
      --name=hadoop03 --link hadoop01:hadoop01 -P cybermaggedon/hadoop:2.7.3
      
```

or a Yarn cluster:

```

  # Master
  docker run --rm -e DAEMONS=resourcemanager,nodemanager \
      -e RESOURCEMANAGER_HOSTNAME=localhost --name=hadoop01 \
      -p 8088:8088 cybermaggedon/hadoop:2.7.3

  # Slaves
  docker run --rm -e DAEMONS=nodemanager -e RESOURCEMANAGER_HOSTNAME=hadoop01 \
      -e NAMENODE_URI=hdfs://hadoop01:9000 -i -t --name=hadoop02 \
      --link hadoop01:hadoop01 -P cybermaggedon/hadoop:2.7.3
  docker run --rm -e DAEMONS=nodemanager -e RESOURCEMANAGER_HOSTNAME=hadoop01 \
      -e NAMENODE_URI=hdfs://hadoop01:9000 -i -t --name=hadoop03 \
      --link hadoop01:hadoop01 -P cybermaggedon/hadoop:2.7.3

```

Source at <http://github.com/cybermaggedon/hadoop-docker>.


