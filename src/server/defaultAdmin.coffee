userModel = require "./routes/user/userModel"

module.exports = ->
    admin =
        email: "admin@admin"
        password: "admin123"
        language: "bg"
        admin: 2
    (userModel.update email: "admin@admin", admin, {upsert: yes}).exec().then (->
        console.log "admin: #{JSON.stringify admin} was successfuly created"
    ), (err) -> throw err
