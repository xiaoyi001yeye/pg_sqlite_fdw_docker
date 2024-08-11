# pg_sqlite_fdw_docker
pg_sqlite_fdw_docker


## 生成sqlite数据库
1. 安装 SQLite：
在 Ubuntu 或 Debian 上，你可以使用以下命令：

```shell
sudo apt-get update
sudo apt-get install sqlite3
```
2. 创建数据库文件：
使用 sqlite3 命令行工具创建一个新的数据库文件：

```shell
sqlite3 call_log.db
```
3. 创建表：
在 SQLite 的命令行界面中，创建一个表来存储通话记录。例如，你可以创建一个包含日期、时间、来电号码和通话时长的表：

```sql
CREATE TABLE call_logs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    call_date DATE,
    call_time TIME,
    incoming_number VARCHAR(20),
    duration INTEGER
);
```
4. 插入数据：向表中插入一些示例数据：

```sql
INSERT INTO call_logs (call_date, call_time, incoming_number, duration) VALUES
('2024-08-11', '14:22:01', '1234567890', 120),
('2024-08-11', '14:30:21', '0987654321', 90);
```

5. 保存并退出：
完成数据插入后，使用 CTRL+D 退出 SQLite 命令行界面，这将自动保存你的更改。

6. 验证数据库：
你可以再次使用 sqlite3 来验证数据库内容：

```shell
sqlite3 call_log.db
 
```
7. 设置文件权限（如果需要）：
根据你的应用需求，可能需要设置数据库文件的权限，以确保 PostgreSQL 可以访问它：

```shell
chmod 666 call_log.db
```
8. 移动数据库文件：
如果你需要将数据库文件移动到特定的目录：

```
COPY call_log.db /tmp/call_log.db
```