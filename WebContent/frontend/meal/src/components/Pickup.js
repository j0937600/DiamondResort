import React, { useState } from 'react';
import axios from 'axios';

const Pickup = ({ bookingId }) => {
  const [pickupTime, setPickupTime] = useState('');

  const schedulePickup = async () => {
    try {
      await axios.post('/api/schedule-pickup', { bookingId, pickupTime });
      alert('Pickup scheduled successfully!');
    } catch (error) {
      console.error('Error scheduling pickup:', error);
    }
  };

  return (
    <div>
      <h3>Schedule Your Pickup</h3>
      <input
        type="datetime-local"
        value={pickupTime}
        onChange={(e) => setPickupTime(e.target.value)}
      />
      <button onClick={schedulePickup}>Schedule Pickup</button>
    </div>
  );
};

export default Pickup;
