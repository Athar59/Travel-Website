package com.travel.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.travel.model.Package;

public class PackageDao {
    public static List<Package> getAllPackages() {
        List<Package> packages = new ArrayList<>();
        try {
            Connection conn = DBConnection.getConnection();
            String query = "SELECT * FROM packages";
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                packages.add(new Package(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("image_url")
                ));
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return packages;
    }
}
