import React, { useState, useEffect } from 'react';
import BookingItem from '../components/BookingItem';
import TotalPrice from '../components/TotalPrice';
import axios from 'axios';

const Booking = () => {
  const [bookingCart, setBookingCart] = useState([]);

  useEffect(() => {
    const fetchBookingCart = async () => {
      const response = await axios.get('/api/booking-cart');
      setBookingCart(response.data);
    };
    fetchBookingCart();
  }, []);

  const removeBooking = (roomCardId) => {
    setBookingCart(bookingCart.filter(item => item.roomCardId !== roomCardId));
    // Remove booking from the backend as well
  };

  const total = bookingCart.reduce((acc, item) => acc + parseInt(item.subtotal), 0);

  return (
    <div>
      <h2>Your Booking</h2>
      <div>
        {bookingCart.map(roomCard => (
          <BookingItem key={roomCard.roomCardId} roomCard={roomCard} removeBooking={removeBooking} />
        ))}
      </div>
      <TotalPrice total={total} />
    </div>
  );
};

export default Booking;
