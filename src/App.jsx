import { useState } from 'react';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Home from '../src/Home.jsx';
import Registration from "../src/AuthPages/Registration.jsx";
import Login from "../src/AuthPages/Registration.jsx";
import Header from './Components/Header.jsx';
import Footer from './Components/Footer.jsx';

function App() {

  return (
    <>
      <BrowserRouter>
        <Header/>
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/registration" element={<Registration />} />
          <Route path="/login" element={<Login />} />
        </Routes>
        <Footer/>
      </BrowserRouter>
    </>
  )
}

export default App;
