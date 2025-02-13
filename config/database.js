import mongoose from 'mongoose';

// mongoose.connect(process.env.DATABASE_URL);

// const db = mongoose.connection;

// db.on('connected', function () {
//   console.log(`Connected to ${db.name} at ${db.host}:${db.port}`);
// });

mongoose.connect(process.env.DATABASE_URL).then(()=>{
  console.log('Connected to MongoDB');
}).catch((err)=>{
  console.log(err);
});