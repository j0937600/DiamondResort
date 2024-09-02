import React, { useState, useEffect } from 'react';
import axios from 'axios';

const Meal = () => {
  const [meals, setMeals] = useState([]);

  useEffect(() => {
    const fetchMeals = async () => {
      const response = await axios.get('/api/meals');
      setMeals(response.data);
    };
    fetchMeals();
  }, []);

  return (
    <div>
      <h2>Meal Options</h2>
      <ul>
        {meals.map(meal => (
          <li key={meal.id}>{meal.name} - ${meal.price}</li>
        ))}
      </ul>
    </div>
  );
};

export default Meal;
