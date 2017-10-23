mongoimport --db labJSON  --collection cities --file cities.json
mongoimport --db labJSON  --collection moviepeople3000 --file moviepeople-3000.json
mongo
> use labJSON
## Question 2
> db.moviepeople3000.find({"person-name" : "Teixeira, Anabela"})}	
## Question 3
> db.moviepeople3000.find({"person-name": "Spielberg, Steven"},{"info.birthnotes" : 1}).pretty()
## Question 4
> db.moviepeople3000.find({"info.birthnotes" : {$regex : ".*Lisbon.*"}}).count()
## Question 5
> load("usctosi.js")
> db.moviepeople3000.find({"info.height"  : {$gt : "170"}}, {"person-name":1, "info.height" : 1, "_id":0}).forEach(usctosi)
## Question 6
> load("lookforinfo.js")
db.moviepeople3000.find({},{"_id":0, "info":1, "person-name":1}).forEach(lookforinfo)
## Question 7
> load("citycoor.js")
> db.moviepeople3000.find({}, {"_id":0,"info.birthnotes":1,"person-name":1}).forEach(citycoor)
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
      { _id : 0, host : "localhost:27015" },
      { _id : 1, host : "localhost:27016" },
    ]
  }
)
> exit
mongos --configdb  city/localhost:27010 --chunkSize 1 --port 27020
mongoimport --db labJSON  --collection cities --file cities.json --port 27015
mongo localhost:27020/admin 
> sh.addShard( "citydata/localhost:27015")
> sh.addShard( "citydata/localhost:27016")
> sh.enableSharding("labJSON")
> sh.shardCollection("labJSON.cities", key: {name: 1})







