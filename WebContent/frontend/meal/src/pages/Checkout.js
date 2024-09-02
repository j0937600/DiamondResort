import React, { useState, useEffect } from 'react';
import PaymentInfo from '../components/PaymentInfo';
import axios from 'axios';

const Checkout = () => {
  const [cards, setCards] = useState([]);

  useEffect(() => {
    const fetchCards = async () => {
      const response = await axios.get('/api/payment-methods');
      setCards(response.data);
    };
    fetchCards();
  }, []);

  const addCreditCard = () => {
    // Logic for adding a new credit card
  };

  return (
    <div>
      <h2>Checkout</h2>
      <PaymentInfo cards={cards} addCreditCard={addCreditCard} />
    </div>
  );
};

export default Checkout;
