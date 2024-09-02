import React from 'react';
import Pickup from '../components/Pickup';

const PickupPage = ({ match }) => {
  return (
    <div>
      <Pickup bookingId={match.params.id} />
    </div>
  );
};

export default PickupPage;
