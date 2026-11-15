// Connects the website to the Supabase database.
// Paste your own values from Supabase: Project Settings > API
const SUPABASE_URL = "https://ncqrxwictjrxkhtukjsx.supabase.co";
const SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5jcXJ4d2ljdGpyeGtodHVranN4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3OTQ2NTg0MjUsImV4cCI6MjExMDIzNDQyNX0.u8W738mwuOLaMrooJLDhqS1ffM7c-a3TpmT-fHTnz5I";
const db = supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

// Makes text safe before putting it inside HTML
function safe(text) {
    const div = document.createElement("div");
    div.textContent = text ?? "";
    return div.innerHTML;
}

// Picks one of 8 cover colours (cover-0 ... cover-7) from the book title,
// so the same book always gets the same colour
function coverClass(title) {
    let total = 0;
    for (const letter of title) total += letter.charCodeAt(0);
    return "cover-" + (total % 8);
}
