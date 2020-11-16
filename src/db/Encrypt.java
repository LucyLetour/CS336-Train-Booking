package db;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

public class Encrypt {

    public static SecureRandom random = new SecureRandom();

    public static Boolean checkPassword(String attempt, int salt, String passwordHash) {
        return passwordHash.equals(hashNewPassword(salt, attempt));
    }

    public static String hashNewPassword(int s, String password) {

        byte[] salt = BigInteger.valueOf(s).toByteArray();
        MessageDigest md = null;
        try {
            md = MessageDigest.getInstance("SHA-512");
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        // Salt
        assert md != null;
        md.update(salt);

        // Create hash
        byte[] messageDigest = md.digest(password.getBytes());

        // Convert hash to bigint
        BigInteger no = new BigInteger(1, messageDigest);

        // Convert hash to base 16 string
        StringBuilder hashText = new StringBuilder(no.toString(16));

        // Pad hash to ensure 32 bits
        while(hashText.length() < 128) {
            hashText.insert(0, "0");
        }
        return hashText.toString();
    }

    public static int getNewSalt() {
        byte[] salt = new byte[4];
        random.nextBytes(salt);
        return new BigInteger(salt).intValue();
    }
}