import { redirect } from 'next/navigation';

export default function Page() {
    // Redirect to the landing page
    redirect('/Dashboard');
    return null; // This component does not render anything
}