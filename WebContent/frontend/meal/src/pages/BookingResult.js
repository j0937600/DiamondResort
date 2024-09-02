import React, { useState, useEffect } from 'react';
import ResultReceipt from '../components/ResultReceipt';
import axios from 'axios';

const BookingResult = ({ match }) => {
  const [booking, setBooking] = useState(null);

  useEffect(() => {
    const fetchBooking = async () => {
      const response = await axios.get(`/api/bookings/${match.params.id}`);
      setBooking(response.data);
    };
    fetchBooking();
  }, [match.params.id]);

  return (
    <div>
      {booking ? <ResultReceipt booking={booking} /> : <p>Loading...</p>}
    </div>
  );
};

export default BookingResult;
