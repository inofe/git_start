import React, { useState } from 'react';
import { BrowserRouter as Router, Route, Switch } from 'react-router-dom';
import Dashboard from './components/Dashboard';
import DomainManager from './components/DomainManager';
import UserManager from './components/UserManager';

function App() {
  return (
    <Router>
      <div className="App">
        <nav>
          <ul>
            <li><Link to="/">Dashboard</Link></li>
            <li><Link to="/domains">Domains</Link></li>
            <li><Link to="/users">Users</Link></li>
          </ul>
        </nav>

        <Switch>
          <Route exact path="/" component={Dashboard} />
          <Route path="/domains" component={DomainManager} />
          <Route path="/users" component={UserManager} />
        </Switch>
      </div>
    </Router>
  );
}

export default App; 