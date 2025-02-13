import 'swiper/css/bundle';

export default function Home() {
  return (
    <div className='pb-20 z-10'>
      <div className='flex flex-col gap-6 p-40 px-3 max-w-6xl mx-auto'>
        <h1 className='text-slate-900 font-bold text-3xl lg:text-5xl'>
          Find your next <span className='text-slate-400'>humble abode</span> <br />
          with ease.
        </h1>
        <div className='text-slate-800 text-md font-bold sm:text-lg'>
          RealEstate will help you find your next home with comfort and ease. <br />
          There is a large range of properties to choose from.
        </div>

        <div to={''} className='text-sm sm:text-lg text-blue-800 font-bold hover:underline'>
          Let's get started!
        </div>
      </div>
    </div>
  )
}