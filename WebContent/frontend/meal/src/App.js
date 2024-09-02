import React from 'react';
import { Route, Switch } from 'react-router-dom';
import Available from './pages/Available';
import Booking from './pages/Booking';
import Checkout from './pages/Checkout';
import BookingResult from './pages/BookingResult';
import Pickup from './pages/Pickup';
import Meal from './pages/Meal';
import Header from './components/Header';

const App = () => {
  return (
    <div>
      <Header />
      <Switch>
        <Route path="/available" component={Available} />
        <Route path="/booking" component={Booking} />
        <Route path="/checkout" component={Checkout} />
        <Route path="/bookingResult" component={BookingResult} />
        <Route path="/pickup" component={Pickup} />
        <Route path="/meal" component={Meal} />
        <Route path="/" component={Available} /> {/* Default route */}
      </Switch>
    </div>
  );
};

export default App;
