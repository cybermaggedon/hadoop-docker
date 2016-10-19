
Single-node Hadoop container for development purposes.  Runs DFS and Yarn.

To run:

  docker run -p9000:9000 cybermaggedon/hadoop:2.7.3

To persist data, mount a volume on /data:

  docker run -p9000:9000 -v /data/hadoop:/data cybermaggedon/hadoop:2.7.3

