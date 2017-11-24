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
      color: "red",
      mode: "semi",
    });
    this.setState({
      timer, 
      joystickManager
    });
    joystickManager.on('added', (evt, joystick) => {
      joystick.on('move', (evt, data) => {
        let joystickData = {...data};
        delete joystickData['instance'];
        this.setState({joystickData});
      });
      joystick.on('end', (evt, joystick) => {
        this.setState({joystickData: undefined});
      });
    }).on('removed', (evt, joystick) => {
      joystick.off('start move end dir plain');
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
    return (<div id="joystick" style={{width: "500px", height: "500px"}}></div>);
  }
}

export default App;
