db.createCollection('students')
db.students.insertMany([
    { _id : 1, grades : [ 95, 92, 90 ]},
    { _id : 2, grades : [ 98, 100, 102 ]},
    { _id : 3, grades : [ 95, 110, 100 ]}
])

db.students2.insertMany([
    {
       _id : 1,
       grades : [
          { grade : 80, mean : 75, std : 6 },
          { grade : 85, mean : 90, std : 4 },
          { grade : 85, mean : 85, std : 6 }
       ]
    },
    {
       _id : 2,
       grades : [
          { grade : 90, mean : 75, std : 6 },
          { grade : 87, mean : 90, std : 3 },
          { grade : 85, mean : 85, std : 4 }
       ]
    }
])

db.students2.updateMany(
	{},
		{ $set : { "grades.$[grip].mean" : 100}},
			{ arrayFilters: [{"grip.grade" : {$gte : 85}}]}
			)
			
			
db.students3.insertMany([
    {
        "_id": 1,
        "alias": [ "The American Cincinnatus", "The American Fabius" ],
        "nmae": { "first" : "george", "last" : "washington" }
    },    
    {
        "_id": 2,
        "alias": [ "My dearest friend" ],
        "nmae": { "first" : "abigail", "last" : "adams" }
    },
    {
        "_id": 3,
        "alias": [ "Amazing grace" ],
        "nmae": { "first" : "grace", "last" : "hopper" }
    }
])
// $rename - renames a field
db.students3.updateMany(
    {},
    { $rename: { "nmae": "name" }}
)

db.students3.updateOne(
    { "_id": 1},
    { $rename: { "name.first": "fname" }}
)

