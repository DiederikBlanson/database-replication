# ProxySQL

ProxySQL is a high-performance, open-source proxy for MySQL databases. It acts as a middleman between your application and your database, routing queries and managing connections to ensure optimal performance and security.

(TODO: elaborate on use cases)

## Architecture
![Design](proxysql.png)
We have two nodes, A and B, where a MySQL master is running on node A and a MySQL slave on node B. In addition, there are two additional processes, which are located on node A but could also be on separate nodes:

1. `ProxySQL Admin`: This process is responsible for configuring ProxySQL and runs on port 6032. It communicates with the targeted MySQL instances.
2. `ProxySQL Client`: Client queries are routed to port 6033, where ProxySQL redirects traffic to one of the nodes based on a set of rules, such as read-write splitting or user-based routing.

## Installation
The replication must already be set up, as outlined in the document `1-setup-replication.md`, which is one of the necessary requirements. Next, the following steps should be performed.

### 1. Download ProxySQL
Retrieve ProxySQL package: \
`wget https://github.com/sysown/proxysql/releases/download/v2.0.4/proxysql_2.0.4-ubuntu16_amd64.deb`

Install package: \
`sudo dpkg -i proxysql_2.0.4-ubuntu16_amd64.deb`

Start ProxySQL: \
`sudo systemctl start proxysql`

### 2. Configure ProxySQL
Follow step 2 until step 8 from https://www.digitalocean.com/community/tutorials/how-to-use-proxysql-as-a-load-balancer-for-mysql-on-ubuntu-16-04 (TODO: elaborate on steps)

Some important notes:
- The initial password of the ProxySQLAdmin client is 'admin'
- When creating the monitor/playground user, use native_password instead of caching_ (temporary solution)

## Useful commands

### Listen to traffic on port 3306
`tcpdump port 3306 and '(tcp-syn|tcp-ack)!=0'`

### See status of each host in ProxySQL
`SELECT hostname, from_unixtime(time_start_us/1000000) AS last_check, ping_error AS error from monitor.mysql_server_ping_log group by hostname order by time_start_us desc`

### Example of ProxySQL rules
With the following example, we redirect all traffic that starts with `SELECT COUNT` to the destination group `2`: 

`INSERT INTO mysql_query_rules (rule_id, active, match_digest, destination_hostgroup, apply) VALUES (1, 1, '^SELECT COUNT.*$', 3, 1);`

### Example query in the ProxySQL client
See which host is used for the MySQL query:

`mysql -u playgrounduser -pplaygroundpassword -h 127.0.0.1 -P 6033 --prompt='ProxySQLClient> ' -e 'SELECT @@hostname;'`


## Sources
- Issue read-only https://github.com/sysown/proxysql/issues/2074
- ProxySQL https://proxysql.com/documentation/
- Installation ProxySQL https://www.arubacloud.com/tutorial/how-to-optimize-mysql-queries-with-proxysql-caching-on-ubuntu-20-04.aspx