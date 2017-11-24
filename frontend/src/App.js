import React, { Component } from 'react';
import './App.css';

class App extends Component {
  state = {
    timer: null,
    counter: 0
  };
  
  componentDidMount() {
    let timer = setInterval(this.tick.bind(this), 100);
    let joystickManager = require('nipplejs').create({
      zone: document.getElementById('joystick'),
      color: "blue",
      mode: "static",
      size: 200,
      position: {top: "50%", left: "50%"}
    });
    this.setState({
      timer, 
      joystickManager
    });
    joystickManager.on('move', (evt, data) => {
      let joystickData = {...data};
      delete joystickData['instance'];
      this.setState({joystickData});
    });
    joystickManager.on('end', (evt, joystick) => {
      this.setState({joystickData: undefined});
    });
  }
  
  componentWillUnmount() {
    clearInterval(this.state.timer);
  }
  
  tick() {
    if (this.state.joystickData) {
      let axios = require('axios');
      axios.post('/api/joystick/receive', this.state.joystickData);
    }
  }
  
  render() {
    return (<div id="joystick"></div>);
  }
}

export default App;
