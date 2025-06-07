/** @type {import('next').NextConfig} */
const nextConfig = {
  async redirects() {
    return [
      {
        source: '/',
        destination: '/Dashboard',
        permanent: true,
      },
    ]
  },
}



export default nextConfig;
