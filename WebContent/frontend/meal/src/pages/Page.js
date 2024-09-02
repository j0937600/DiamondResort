import React, { useState, useEffect } from 'react';
import RoomCard from '../components/RoomCard';
import axios from 'axios';

const Available = () => {
  const [rooms, setRooms] = useState([]);

  useEffect(() => {
    const fetchRooms = async () => {
      const response = await axios.get('/api/rooms');
      setRooms(response.data);
    };
    fetchRooms();
  }, []);

  const addToCart = (roomId) => {
    // Add room to cart logic
  };

  return (
    <div>
      <h2>Available Rooms</h2>
      <div>
        {rooms.map(room => (
          <RoomCard key={room.id} room={room} addToCart={addToCart} />
        ))}
      </div>
    </div>
  );
};

export default Available;
