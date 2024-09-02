import React from 'react';

const Header = ({ member }) => {
  return (
    <header className="booking-header">
      <div className="member-section">
        {member ? (
          <>
            <i className="far fa-gem"></i>
            <ul className="dropdown">
              <li><a href="/frontend/members/memberInfo.jsp">個人檔案</a></li>
              <li><a href="/frontend/members/memberBooking.jsp">我的假期</a></li>
              <li><a href="/LoginHandler?action=member-logout">登出</a></li>
            </ul>
          </>
        ) : (
          <>
            <i className="far fa-user"></i>
            <ul className="dropdown">
              <li><a className="log-in">登入會員</a></li>
              <li><a href="/frontend/registration.jsp">註冊會員</a></li>
            </ul>
          </>
        )}
      </div>
      <div className="logo">
        <img src="/img/logo.png" alt="Logo" />
      </div>
    </header>
  );
};

export default Header;
