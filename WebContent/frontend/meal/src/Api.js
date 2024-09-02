import axios from 'axios';

export const fetchRooms = () => axios.get('/api/rooms');
export const fetchBookingCart = () => axios.get('/api/booking-cart');
export const fetchCards = () => axios.get('/api/payment-methods');
export const fetchBooking = (id) => axios.get(`/api/bookings/${id}`);
export const fetchMeals = () => axios.get('/api/meals');
