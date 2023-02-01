# Master-Master or Master-Slave replication

The purpose of this repository is to demonstrate the ease of implementing database replication in a MySQL environment on an Ubuntu 20.04 server. While this setup is not suitable for production due to limitations such as node failure, it provides an opportunity to experiment and explore the possibilities of replication.

The process begins with establishing the master/slave replication environment, detailed in `1-setup-replication.md`. Subsequently, proxysql is utilized to manage traffic using various rules, such as user-based and query-based load balancing, described in `2-proxysql.md`.