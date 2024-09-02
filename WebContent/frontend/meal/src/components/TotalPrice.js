import React from 'react';

const TotalPrice = ({ total }) => {
  return (
    <div className="variables booking-confirm">
      <div className="last-price">
        <p>Total Price</p>
        <h3 className="last-price">USD${total}</h3>
      </div>
      <div className="last-price">
        <p>Deposit Rate</p>
        <h3 className="deposit-price">
          USD${(total * 0.3).toFixed(2)}
        </h3>
      </div>
    </div>
  );
};

export default TotalPrice;
