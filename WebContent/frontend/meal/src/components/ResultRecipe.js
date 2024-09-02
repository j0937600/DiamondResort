import React from 'react';

const ResultReceipt = ({ booking }) => {
  return (
    <div>
      <h2>Booking Receipt</h2>
      <p>Booking ID: {booking.id}</p>
      <p>Total Price: USD${booking.totalPrice}</p>
      {/* Additional receipt details */}
    </div>
  );
};

export default ResultReceipt;
