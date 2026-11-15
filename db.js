// Connects the website to the Supabase database.
// Paste your own values from Supabase: Project Settings > API
const SUPABASE_URL = "PASTE_YOUR_PROJECT_URL";
const SUPABASE_KEY = "PASTE_YOUR_ANON_KEY";

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
