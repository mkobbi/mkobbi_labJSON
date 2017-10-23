mkdir -p data/db1 data/db2 data/db3
#mongod --dbpath /var/lib/mongod --replSet "small-movie"
mongod --dbpath data/db1 --port 27018 --replSet "small-movie" --quiet &
mongod --dbpath data/db2 --port 27019 --replSet "small-movie" --quiet & 
mongod --dbpath data/db3 --port 27020 --replSet "small-movie" --quiet & 
mongo --port 27018
rs.initiate( {
   _id : "small-movie",
   members: [ { _id : 0, host : "localhost:27018" } ]
})

rs.conf()
rs.add("localhost:27019")
rs.add("localhost:27020")


mkdir data/arb
mongod --port 30000 --dbpath data/arb --replSet "small-movie" --quiet &
mongo --port 27018
rs.addArb("localhost:30000")



2017-10-20T12:20:58.481+0200 I REPL     [ReplicationExecutor] Member localhost:27018 is now in state PRIMARY
2017-10-20T12:20:58.481+0200 I REPL     [ReplicationExecutor] Member localhost:27019 is now in state SECONDARY
2017-10-20T12:20:58.481+0200 I REPL     [ReplicationExecutor] Member localhost:27020 is now in state SECONDARY
2017-10-20T12:20:58.481+0200 I REPL     [ReplicationExecutor] Member localhost:30000 is now in state ARBITER
## Question 9
mongoimport --port 27018 --collection moviepeople10 --file moviepeople-10.json 
[initandlisten] connection accepted from 127.0.0.1:56554 #8 (4 connections now open)
2017-10-23T19:59:25.014+0200 I NETWORK  [initandlisten] connection accepted from 127.0.0.1:56556 #9 (5 connections now open)
2017-10-23T20:05:43.826+0200 I NETWORK  [initandlisten] connection accepted from 127.0.0.1:44156 #14 (6 connections now open)
2017-10-23T20:05:43.854+0200 I NETWORK  [conn14] end connection 127.0.0.1:44156 (5 connections now open)
## Question 10
mongod --configsvr --replSet city --dbpath data/db --port 27010 &
mongo --port 27010
> rs.initiate(
  {
    _id: "city",
    configsvr: true,
    members: [
      { _id : 0, host : "localhost:27010" }
    ]
  }
)
> exit
mongod --shardsvr --replSet citydata --port 27015 --dbpath data/db5
mongod --shardsvr --replSet citydata --port 27016 --dbpath data/db6
mongo --port 27015
> rs.initiate(
  {
    _id : "citydata",
    members: [
      { _id : 0, host : "localhost:27015" }
    ]
  }
)
rs.conf()
rs.add("localhost:27016")
> exit
mongos --configdb  city/localhost:27010 --chunkSize 1 --port 27020
mongoimport  --collection cities --file cities.json --port 27015
mongo localhost:27020/admin 
> sh.addShard( "citydata/localhost:27015")
> sh.addShard( "citydata/localhost:27016")
> sh.enableSharding("labJSON")
> sh.shardCollection("labJSON.cities", key: {name: 1})

