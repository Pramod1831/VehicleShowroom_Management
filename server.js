const express = require('express');
const mysql = require('mysql2');
const path = require('path');
const bodyParser = require('body-parser');
const session = require('express-session'); // For session management
const app = express();
const PORT = 3000;

// MySQL connection setup
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'Pramod@2140', 
  database: 'BikeShowroom'
});

// Connect to the MySQL database
connection.connect(error => {
  if (error) {
    console.error('Error connecting to the database:', error);
    return;
  }
  console.log('Connected to the MySQL database.');
});

// Middleware
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));

// Session setup
app.use(session({
  secret: 'your_secret_key', // Replace with a strong secret key
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false } // Set secure to true in production with HTTPS
}));

// Middleware to check if user is logged in
function checkAuth(req, res, next) {
  if (req.session.user) {
    next();
  } else {
    res.redirect('/login.html');
  }
}

// Routes

// Serve index page (protected)
app.get('/', checkAuth, (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// Serve login page
app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'login.html'));
});

// Handle login
app.post('/login', (req, res) => {
  const { username, password } = req.body;
  connection.query('SELECT * FROM Users WHERE username = ? AND password = ?', [username, password], (error, results) => {
    if (error) {
      console.error('Error during login:', error);
      res.status(500).json({ success: false });
    } else if (results.length > 0) {
      req.session.user = username; // Set user session
      res.json({ success: true });
    } else {
      res.json({ success: false });
    }
  });
});

// Handle signup
app.post('/signup', (req, res) => {
  const { username, password } = req.body;
  connection.query('INSERT INTO Users (username, password) VALUES (?, ?)', [username, password], (error, results) => {
    if (error) {
      console.error('Error during signup:', error);
      res.status(500).json({ success: false });
    } else {
      res.json({ success: true });
    }
  });
});

// Handle logout
app.get('/logout', (req, res) => {
  req.session.destroy(err => {
    if (err) {
      return res.redirect('/');
    }
    res.clearCookie('connect.sid');
    res.redirect('/login.html');
  });
});

// Routes to fetch data (protected)
app.get('/bikes', checkAuth, (req, res) => {
  connection.query('SELECT * FROM Bikes', (error, results) => {
    if (error) {
      console.error('Error fetching bikes:', error);
      res.status(500).send('Error fetching bikes');
    } else {
      res.json(results);
    }
  });
});

app.get('/sales', checkAuth, (req, res) => {
  connection.query('SELECT * FROM Sales', (error, results) => {
    if (error) {
      console.error('Error fetching sales:', error);
      res.status(500).send('Error fetching sales');
    } else {
      res.json(results);
    }
  });
});

app.get('/services', checkAuth, (req, res) => {
  connection.query('SELECT * FROM Service', (error, results) => {
    if (error) {
      console.error('Error fetching services:', error);
      res.status(500).send('Error fetching services');
    } else {
      res.json(results);
    }
  });
});

app.get('/customers', checkAuth, (req, res) => {
  connection.query('SELECT * FROM Customers', (error, results) => {
    if (error) {
      console.error('Error fetching customers:', error);
      res.status(500).send('Error fetching customers');
    } else {
      res.json(results);
    }
  });
});

// Start the server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
