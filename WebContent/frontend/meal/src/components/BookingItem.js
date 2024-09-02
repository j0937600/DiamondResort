import React from 'react';

const BookingItem = ({ roomCard, removeBooking }) => {
  return (
    <div className="room-card">
      <div className="booking-item-title">
        <h4>房間</h4>
      </div>
      <div className="booking-date">
        <img className="booking-icons" src="/img/icon/calendar.png" alt="Calendar" />
        <h4>{`${roomCard.startDate} - ${roomCard.leaveDate} (${roomCard.stay} 晚)`}</h4>
      </div>
      <div className="booking-guest">
        <img className="booking-icons" src="/img/icon/user.png" alt="User" />
        <h4>{`${roomCard.guest} 成人`}</h4>
      </div>
      <div className="booking-short-intro">
        <h3 className="room-title">{roomCard.typeName}</h3>
        <img src={roomCard.imageUrl} alt={roomCard.typeName} />
      </div>
      <div className="booking-total-price">
        <h5>價格小計</h5>
        <h4>
          <span>USD$</span><span className="subtotal">{roomCard.subtotal}</span>
          <span className="etc">＊價格已含稅,服務費</span>
        </h4>
      </div>
      <div className="remove-button">
        <button onClick={() => removeBooking(roomCard.roomCardId)}>
          <i className="far fa-trash-alt"></i>移除
        </button>
      </div>
    </div>
  );
};

export default BookingItem;
