const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const port = 3000;

let users = [];

app.use(bodyParser.json());

app.post('/register', (req, res) => {
  const { nom, prenom, email, password, phone } = req.body;

  // Vérifiez si l'email est déjà utilisé
  const existingUser = users.find(user => user.email === email);
  if (existingUser) {
    return res.status(400).json({ error: 'Cet email est déjà utilisé' });
  }

  const newUser = { nom, prenom, email, password, phone };
  users.push(newUser);

  res.status(200).json({ message: 'Inscription réussie' });
});

app.listen(port, () => {
  console.log(`Serveur démarré sur le port ${port}`);
});
