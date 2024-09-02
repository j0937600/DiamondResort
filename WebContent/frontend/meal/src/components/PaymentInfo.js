import React, { useState } from 'react';

const PaymentInfo = ({ cards, addCreditCard }) => {
  const [selectedCard, setSelectedCard] = useState('');

  const handlePayment = () => {
    // Redirect to payment handler with selected card
    window.location.href = `/bookingServlet?action=insert_bkod&card_no=${selectedCard}`;
  };

  return (
    <div id="payment-info">
      <h2>請選擇付款信用卡</h2>
      <div className="credit-cards">
        {cards.map(card => (
          <div
            key={card.pay_no}
            className="creditcard"
            onClick={() => setSelectedCard(card.card_no)}
          >
            <h4 className="cardnumber">{card.card_no}</h4>
            <h6>CARDHOLDER NAME</h6>
            <p className="cardholder">{card.card_name}</p>
            <p className="exp">{`${card.exp_mon}/${card.exp_year}`}</p>
            <input
              name="pay_no"
              className="pay_no"
              style={{ display: 'none' }}
              value={card.pay_no}
            />
            <div className="creditcard-logo">
              <img src="/img/creditcard/master.png" alt="Credit Card" />
            </div>
          </div>
        ))}
      </div>
      <button className="add-creditcard" onClick={addCreditCard}>
        新增信用卡
      </button>
      <button className="leave-payment" onClick={() => setSelectedCard('')}>
        取消付款
      </button>
      <button onClick={handlePayment} disabled={!selectedCard}>
        付款
      </button>
    </div>
  );
};

export default PaymentInfo;
