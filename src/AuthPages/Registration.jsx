import {useState, useEffect} from 'react';
import {Link, useNavigate} from 'react-router-dom';

export default function Registration() {
  const [formData, setFormData] = useState({});
  const [error, setError] = useState(null);
  const [emailError, setEmailError] = useState(null);
  const [passwordValue, setPasswordValue] = useState('');
  const [loading, setLoading] = useState(false);
  const [isPasswordSame, setIsPasswordSame] = useState(false);
  const [isButtonDisabled, setIsButtonDisabled] = useState(false);
  const navigate = useNavigate();

  const isAtLeast8Characters = passwordValue.length >= 8; // Checks if the password has at least 8 characters.
  const hasCapitalLetter = /[A-Z]/.test(passwordValue);   // Validates the presence of at least one uppercase letter.
  const hasNumber = /[0-9]/.test(passwordValue);          // Validates the presence of at least one digit.
  const hasSpecialCharacter = /[!@#$%^&*(),.?":{}|<>]/.test(passwordValue); // Validates at least one special character.

  function arePasswordsSameToggle() {
    if(confirmpassword.value == '' && password.value == '') {
      // setIsPasswordSame(true);
      setIsButtonDisabled(true);
    } else {
      // setIsPasswordSame(false);
      setIsButtonDisabled(false);
    }
  }

  useEffect(() => {
    arePasswordsSameToggle();
  }, []);

  function passwordToggle() {
    var x = document.getElementById("password");
    var y = document.getElementById("confirmpassword");
    if (x.type === "password" && y.type === "password") {
      x.type = "text";
      y.type = "text";
    } else {
      x.type = "password";
      y.type = "password";
    }
  }

  const handleChange = (e) => {
    setFormData({
      ...formData,
      username: username.value.toLowerCase().split(" ").join(""),
      [e.target.id]: e.target.value,
    });
  
    setPasswordValue(password.value);
  
    const emailRegex = /^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$/;
    const isEmailValid = email.value === '' || emailRegex.test(email.value);
  
    if ((confirmpassword.value == password.value) && (confirmpassword.value != '' && password.value != '')) {
      console.log('same passwords');
      setIsPasswordSame(true);
    } else {
      console.log('not same passwords');
      setIsPasswordSame(false);
    }
  
    if (isEmailValid && email.value != '' && username.value != '' && fullname.value != '' && confirmpassword.value == password.value && isAtLeast8Characters && hasCapitalLetter && hasNumber && hasSpecialCharacter) {
      setIsButtonDisabled(false);
    } else {
      setIsButtonDisabled(true);
      if (email.value !== '' && !emailRegex.test(email.value)) {
        setEmailError("Invalid email format. Please enter a valid email address.");
      } else {
        setEmailError(null); // Reset the error if email is valid
      }
    }
  };

  const handleSubmit = async (e) =>{
    e.preventDefault();
    try{
      setLoading(true);
      const res = await fetch('/api/auth/signup', {
        method: 'POST',
        headers:{
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(formData),
      });
  
      const data = await res.json();
      if(data.success === false){
        const message = JSON.stringify(data.message);
        if (message.includes("username_1") ){
          setError("Username already exists. Please enter another username.");
        }
        else{
          setError("Email ID already exists. Please enter another email ID or login using the existing id.");
        }
        setLoading(false);
        return;
      }
      setLoading(false);
      setError(null);
      alert('Congratulations, you have signed up successfully. You will now be redirected to login page.');
      navigate('/sign-in');

    } catch(error){
      setLoading(false);
      setError(null);
    }
  }

  return (
    <div className='p-3 max-w-lg mx-auto pb-32'>
      <h1 className='text-3xl text-center font-semibold my-7'>Sign Up</h1>

      <form onSubmit={handleSubmit} className='flex flex-col gap-4'>
        <input type="text" name="username" id="username" placeholder='Username' className='border p-3 rounded-lg' onChange={handleChange}/>

        <input type="text" name="fullname" id="fullname" placeholder='Full Name' className='border p-3 rounded-lg'  onChange={handleChange}/>  

        <input type="email" name="email" id="email" placeholder='Email' className='border p-3 rounded-lg'  onChange={handleChange}/>
        
        {emailError && <p className='text-red-500'>{emailError}</p>}
        
        <input type="password" name="password" id="password" placeholder='Password' className='border p-3 rounded-lg' onChange={handleChange}/>

        <input type="password" name="password" id="confirmpassword" placeholder='Confirm Password' className='border p-3 rounded-lg' onChange={handleChange}/>
          
        <div className='flex flex-row'>
          <input type="checkbox" onClick={passwordToggle} /> &nbsp; Show Password
        </div>

        <ul className='flex flex-wrap justify-between'>
          {/* Checks if the password meets each condition and dynamically styles the text */}
          <li style={{ color: isAtLeast8Characters ? "green" : "red" }}>
            {isAtLeast8Characters ? "✔" : "✖"} At least 8 characters
          </li>
          <li style={{ color: hasCapitalLetter ? "green" : "red" }}>
            {hasCapitalLetter ? "✔" : "✖"} At least 1 capital letter
          </li>
          <li style={{ color: hasNumber ? "green" : "red" }}>
            {hasNumber ? "✔" : "✖"} At least 1 number
          </li>
          <li style={{ color: hasSpecialCharacter ? "green" : "red" }}>
            {hasSpecialCharacter ? "✔" : "✖"} At least 1 special character
          </li>
          <li style={{ color: isPasswordSame ? "green" : "red" }}>
            {isPasswordSame ? "✔" : "✖"} Passwords Match
          </li>
        </ul>

        <button disabled={isButtonDisabled || loading} id="signUp" className='bg-slate-700 text-white p-3 rounded-lg uppercase hover:placeholder-opacity-95 disabled:opacity-60 disabled:cursor-not-allowed' onChange={handleChange}>
          {loading?'Loading':'Sign Up'}
        </button>
        {/* Reference to Google OAuth */}
        <OAuth />
        
        {error && <p className='text-red-500 mt-5'>{error}</p>}
      </form>

      <div className='flex flex-row gap-2 mt-5'>
        <p>
          Have an account?
        </p>
        <Link to={"/sign-in"}>
          <span className='text-blue-700'>Sign In</span>
        </Link>
      </div>
    </div>
  )
}