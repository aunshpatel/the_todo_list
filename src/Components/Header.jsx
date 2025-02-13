import { Link } from 'react-router-dom';
import { useSelector } from 'react-redux';
import { useEffect, useState } from 'react';

export default function Header() {
//   const { currentUser } = useSelector(state => state.user);
    const currentUser = '';
    const [searchTerm, setSearchTerm] = useState('');
    const [isNavOpen, setIsNavOpen] = useState(false);
    useEffect(() =>{
        const urlParams = new URLSearchParams(location.search);
        const searchTermFromUrl = urlParams.get('searchTerm');
        if(searchTermFromUrl) {
        setSearchTerm(searchTermFromUrl)
        }
  } , [location.search]);

  return (
    <div className="flex items-center justify-between bg-slate-200 p-4 shadow-md">
      <Link to="/">
        <h1 className='font-bold text-2xl flex flex-wrap'>
          <span className='text-slate-500'>Real</span>
          <span className='text-slate-700'>Estate</span>
        </h1>
      </Link>
      <nav>
        <section className="MOBILE-MENU flex lg:hidden">
          <div className="HAMBURGER-ICON space-y-2" onClick={() => setIsNavOpen((prev) => !prev)} >
            <span className="block h-0.5 w-8 animate-pulse bg-gray-600"></span>
            <span className="block h-0.5 w-8 animate-pulse bg-gray-600"></span>
            <span className="block h-0.5 w-8 animate-pulse bg-gray-600"></span>
          </div>

          <div className={isNavOpen ? "showMenuNav" : "hideMenuNav"}>
            <div className="absolute top-0 right-0 px-8 py-8" onClick={() => setIsNavOpen(false)} >
              <svg className="h-8 w-8 text-gray-600" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" >
                <line x1="18" y1="6" x2="6" y2="18" />
                <line x1="6" y1="6" x2="18" y2="18" />
              </svg>
            </div>
            
            {
              currentUser ? (
                <ul className='flex flex-col items-center min-h-[250px] gap-4'>
                    <Link to='/' className="border-b border-gray-400 uppercase" onClick={() => setIsNavOpen(false)} >
                      <li className='text-xl'>Home</li>
                    </Link>
                    <Link to='#' className="border-b border-gray-400 uppercase" onClick={() => setIsNavOpen(false)} >
                        <li className='text-xl'>About</li>
                    </Link>
                </ul>
              ):(
                <ul className='flex flex-col items-center min-h-[250px] gap-6'>
                    <Link to='/' className="border-b border-gray-400 uppercase" onClick={() => setIsNavOpen(false)} >
                      <li className='text-xl'>Home</li>
                    </Link>
                    <Link to='/login' className="border-b border-gray-400 uppercase" onClick={() => setIsNavOpen(false)} >
                      <li className='text-xl'>Login</li>
                    </Link>
                    <Link to='/register' className="border-b border-gray-400 uppercase" onClick={() => setIsNavOpen(false)} >
                      <li className='text-xl'>Register</li>
                    </Link>
                </ul>
              )
            }
          </div>
        </section>
        {
          currentUser ? (
            <ul className='DESKTOP-MENU hidden space-x-8 lg:flex mx-10 sm:text-lg'>
                <Link to='/' className="border-b border-gray-400 uppercase">
                  <li className=''>Home</li>
                </Link>
                <Link to='/about' className="border-b border-gray-400 uppercase">
                    <li className=''>About</li>
                </Link>
                <Link to={"/create-listing"} className="border-b border-gray-400 uppercase">
                  <li className=''>Create New Listing</li>
                </Link>
                <Link to={"/my-listing"} className="border-b border-gray-400 uppercase">
                  <li className=''>My Listings</li>
                </Link>
            </ul>
          ):(
            <ul className='DESKTOP-MENU hidden space-x-8 lg:flex mx-10 sm:text-lg'>
                <Link to='/' className="border-b border-gray-400 uppercase">
                  <li>Home</li>
                </Link>
                <Link to='/login' className="border-b border-gray-400 uppercase" onClick={() => setIsNavOpen(false)} >
                    <li className='text-xl'>Login</li>
                </Link>
                <Link to='/register' className="border-b border-gray-400 uppercase" onClick={() => setIsNavOpen(false)} >
                    <li className='text-xl'>Register</li>
                </Link>
            </ul>
          )
        }
      </nav>
      <style>
      {`
        .hideMenuNav {
          display: none;
        }
        .showMenuNav {
          display: block;
          position: absolute;
          width: 100%;
          height: 80vh;
          top: 0;
          left: 0;
          background: white;
          z-index: 12;
          display: flex;
          flex-direction: column;
          justify-content: space-evenly;
          align-items: center;
        }
    ` }
      </style>
    </div>
  )
}
