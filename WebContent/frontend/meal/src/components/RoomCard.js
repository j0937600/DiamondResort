import React from 'react';

const RoomCard = ({ room, addToCart }) => {
  return (
    <div className="room-card">
      <div className="room-pic">
        {room.images.map((img, index) => (
          <img key={index} src={img} alt={room.typeName} />
        ))}
      </div>
      <div className="room-infos">
        <h3 className="room-title">{room.typeName}</h3>
        <div className="room-cap room-info">
          <i className="fas fa-users"></i>
          {`1~${room.capacity} Guest`}
        </div>
        <div className="room-space room-info">
          <i className="fas fa-expand-arrows-alt"></i> 220㎡
        </div>
        <div className="room-bed room-info">
          <i className="fas fa-bed"></i> King Size
        </div>
      </div>
      <div className="room-price">
        <p className="per-ppl">
          一晚每人<span>USD$</span><span>{room.price}</span>
        </p>
        <h4>
          此為總計<span>USD$</span><span className="subtotal">{room.total}</span>
          <span className="etc">＊價格已含稅,服務費</span>
        </h4>
      </div>
      <div className="room-checkout">
        <button onClick={() => addToCart(room.roomCardId)}>加入預定</button>
      </div>
    </div>
  );
};

export default RoomCard;
